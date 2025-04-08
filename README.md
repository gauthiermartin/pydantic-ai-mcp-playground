# Pydantic AI MCP Postgres Playground

A development playground for exploring Pydantic AI with Model Context Protocol (MCP) integration, using PostgreSQL as the backend database.

## Overview

This project demonstrates how to set up a development environment for Pydantic AI applications with PostgreSQL database integration. It includes a fully configured Docker environment with PostgreSQL and pgAdmin for easy database management.

## Prerequisites

- [Docker](https://www.docker.com/get-started) and Docker Compose installed
- [uv](https://docs.astral.sh/uv/) 
- [Logfire](https://pydantic.dev/logfire) A pydantic logfire account / created a project and a write token

## Getting Started

### Setup

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd pydantic-ai-mcp-playground
   ```

2. Create a `.env` file from the template and fill in the proper values
```bash
cp .env.template .env
```

3. Install version of Python
```bash
uv python install install 3.12
```

4. Create and activate a virtual environment:
   ```bash
   # Create a virtual environment
   uv venv

   # Activate the virtual env
   source .venv/bin/activate
   ```

5. Install dependencies:
   ```bash
   uv sync
   ```

6. Create a new pydantic logfire project / stream
   
7. Start the Docker services:
   ```bash
   docker-compose up -d
   ```
   
   This will spin up:
   - PostgreSQL database on port 5432
   - pgAdmin web interface on port 5050

### Database Access

The PostgreSQL database comes pre-configured with example data (200 entries across users and posts tables).

#### Direct Connection

- Host: localhost
- Port: 5432
- Database: pydantic_ai
- Username: postgres
- Password: postgres

#### Using pgAdmin

1. Access pgAdmin in your browser: http://localhost:5050
2. Login with:
   - Email: admin@example.com
   - Password: admin
3. Add a new server connection:
   - Name: Any name you prefer
   - Connection tab:
     - Host: postgres
     - Port: 5432
     - Database: pydantic_ai
     - Username: postgres
     - Password: postgres

## Project Structure

- `docker-compose.yml` - Docker configuration for PostgreSQL and pgAdmin
- `init-scripts/` - SQL initialization scripts for database setup
- `main.py` - Entry point for the application
- `pyproject.toml` - Project dependencies and metadata

## Database Schema

The database includes the following tables:

### Users Table
- `id` (Primary Key)
- `username`
- `email`
- `created_at`

### Posts Table
- `id` (Primary Key)
- `user_id` (Foreign Key referencing Users)
- `title`
- `content`
- `created_at`

## Usage Example

To run the example it's as simple has running the following command 
```bash
python main.py
```


## Development

To reset the database with fresh data:

```bash
docker-compose down -v
docker-compose up -d
```