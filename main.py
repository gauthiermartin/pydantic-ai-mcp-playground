import asyncio
import logging
import logfire
import os


from dotenv import load_dotenv

from pydantic_ai import Agent
from pydantic_ai.mcp import MCPServerStdio, MCPServerHTTP

load_dotenv()


try:
    log_level = os.environ['LOG_LEVEL']
    log_format = os.environ['LOG_FORMAT']
    log_date_format = os.environ['LOG_DATE_FORMAT']
except KeyError as e:
    raise KeyError(f"Missing environment variable: {e}. Please set it in your .env file.")

logging.basicConfig(
    format=log_format,
    datefmt=log_date_format,
    level=logging.INFO
)

logger = logging.getLogger(__name__)


def setup_instrumentation():
    logfire.configure()
    logfire.instrument_httpx(capture_all=True) 
    logfire.instrument_pydantic_ai()
    

def setup_mcp_server_stdio():
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

def setup_mcp_server_see():
    try:
        postgres_user = os.environ['POSTGRES_USER']
        postgres_password = os.environ['POSTGRES_PASSWORD']
        postgres_host = os.environ['POSTGRES_HOST']        
        postgres_port = os.environ['POSTGRES_PORT']
        postgres_db = os.environ['POSTGRES_DB']
    except KeyError as e:
        raise KeyError(f"Missing environment variable: {e}. Please set it in your .env file.")
    
    

    return MCPServerHTTP(url="http://localhost:8000/sse")

def setup_agent(mcp_servers: list):

    
    system_prompt = """
    Use the PostgreSQL MCP server to analyze the database. 
    Available tools:
    - connect: Register a database connection string and get a connection ID
    - disconnect: Close a database connection
    - pg_query: Execute SQL queries using a connection ID
    - pg_explain: Get query execution plans

    You can explore schema resources via:
    pgmcp://{conn_id}/schemas
    pgmcp://{conn_id}/schemas/{schema}/tables
    pgmcp://{conn_id}/schemas/{schema}/tables/{table}/columns

    A comprehensive database description is available at this resource:
    pgmcp://{conn_id}/
    """

    return Agent('anthropic:claude-3-5-sonnet-latest', 
                instrument=True,
                mcp_servers=mcp_servers
    )


async def main():
    #setup_instrumentation()


    postgres_server = setup_mcp_server_see()
    agent = setup_agent([postgres_server])

    try:
        postgres_user = os.environ['POSTGRES_USER']
        postgres_password = os.environ['POSTGRES_PASSWORD']
        postgres_host = os.environ['POSTGRES_HOST']        
        postgres_port = os.environ['POSTGRES_PORT']
        postgres_db = os.environ['POSTGRES_DB']
    except KeyError as e:
        raise KeyError(f"Missing environment variable: {e}. Please set it in your .env file.")

    async with agent.run_mcp_servers():
        logger.info("Starting Agent loop...")
        result = await agent.run(f"postgresql://{postgres_user}:{postgres_password}@{postgres_host}:{postgres_port}/{postgres_db}")
        
        keep_alive = True
        while keep_alive:
            print("-" * 150)
            print(f"\nAgent > {result.data}")
            user_input = input("\nUser > ")
            if user_input.lower() in ["exit", "quit", "stop"]:
                print("-" * 50)
                keep_alive = False
            else:
                result = await agent.run(user_input, message_history=result.all_messages())
        logger.info("Exiting Agent loop...")

if __name__ == "__main__":
    asyncio.run(main())
