import instructor
from openai import OpenAI
from datetime import datetime

from app.settings import settings
from app.query_agent.config import MetadataFilter, AGENT_SYSTEM_PROMPT


print(settings.OPENAI_API_KEY)

client = instructor.from_openai(OpenAI(api_key=settings.OPENAI_API_KEY))


def get_pinecone_query_from_natural_language_query(natural_language_query: str):
    try:
        metadata_filter = client.chat.completions.create(
            model="gpt-4o",
            response_model=MetadataFilter,
            messages=[{"role": "system", "content": AGENT_SYSTEM_PROMPT.replace("<TODAY_DATE>", datetime.now().strftime("%Y-%m-%d"))},
                {
                    "role": "user",
                    "content": natural_language_query
                }
            ],
            max_tokens=1000,
            temperature=0.0,
            max_retries=2,
            seed=42,
        )

        return metadata_filter

    except Exception as e:
        print(f"Error in get_pinecone_query_from_natural_language_query: {e}")
        return None

