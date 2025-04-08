import asyncio
import os
import logfire


from dotenv import load_dotenv

from pydantic_ai import Agent
from pydantic_ai.mcp import MCPServerStdio

load_dotenv()

def setup_instrumentation():
    logfire.configure()
    logfire.instrument_pydantic_ai()

def setup_mcp_server():
    try:
        postgres_user = os.environ['POSTGRES_USER']
        postgres_password = os.environ['POSTGRES_PASSWORD']
        postgres_host = os.environ['POSTGRES_HOST']        
        postgres_port = os.environ['POSTGRES_PORT']
        postgres_db = os.environ['POSTGRES_DB']
    except KeyError as e:
        raise KeyError(f"Missing environment variable: {e}. Please set it in your .env file.")

    return MCPServerStdio('npx', [
        "-y",
        "@modelcontextprotocol/server-postgres",
        f"postgresql://{postgres_user}:{postgres_password}@{postgres_host}:{postgres_port}/{postgres_db}"
    ])

def setup_agent(mcp_servers: list):
    return Agent('anthropic:claude-3-5-sonnet-latest', 
                instrument=True,
                mcp_servers=mcp_servers)


async def main():
    setup_instrumentation()


    postgres_server = setup_mcp_server()
    agent = setup_agent([postgres_server])

    async with agent.run_mcp_servers():
        result = await agent.run("hello!")
        while True:
            print(f"\n{result.data}")
            user_input = input("\n> ")
            result = await agent.run(user_input, 
                                    message_history=result.new_messages())

if __name__ == "__main__":
    asyncio.run(main())
