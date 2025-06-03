import os

from pydantic_settings import BaseSettings
from dotenv import find_dotenv

print("Loading All App config entries ...!")

class Settings(BaseSettings):
    app_name: str = "pinecone-self-query-agent"
    OPENAI_API_KEY: str


    class Config:
        extra = "allow"


AI_ENV = os.getenv('AI_ENV', 'dev')
env_file = f".env.{AI_ENV.lower()}"

print("Loading All App config entries ...!", env_file)
settings = Settings(_env_file=find_dotenv(env_file))

print("Loaded All App config entries ...!",settings.model_dump_json(indent=4))





