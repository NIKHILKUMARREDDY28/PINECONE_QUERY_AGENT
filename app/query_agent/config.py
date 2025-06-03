from typing import Optional

from pydantic import BaseModel, Field


class MetadataFilter(BaseModel):
    """
    Metadata filter model that can be used in Pinecone queries
    """
    author: Optional[str] = Field(default=None, description="Author name to filter by")
    tags: Optional[dict[str, list[str]]] = Field(default=None, description="Tags to filter by using $in operator")
    published_year: Optional[dict[str, int]] = Field(default=None, description="Year filter with operators like $eq, $gt")
    published_month: Optional[dict[str, int]] = Field(default=None, description="Month filter with operators")
    published_day: Optional[dict[str, int]] = Field(default=None, description="Day filter with operators")
    published_date: Optional[dict[str, str]] = Field(default=None, description="Date range filter with operators")

