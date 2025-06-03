# app/main.py
import sys
import os

from app.query_agent.agent import get_pinecone_query_from_natural_language_query

sys.path.append(os.getcwd())
print(os.getcwd())
from fastapi import FastAPI


app = FastAPI()



@app.post("/generate/query")
async def generate_query(query: str):
    """
    Generate a query based on the provided input.
    """
    pinecone_query = get_pinecone_query_from_natural_language_query(query)
    return {
        "query": pinecone_query
    }


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0")
