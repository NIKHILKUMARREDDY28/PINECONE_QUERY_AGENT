# Use the official Python 3.12 slim image for a small footprint
FROM python:3.12-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    POETRY_VERSION=1.8.2 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_HOME=/opt/poetry \
    PATH="/opt/poetry/bin:$PATH"

# Install Poetry
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    apt-get purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy only the dependency files first for better caching
COPY pyproject.toml ./

# Install only production dependencies without installing the project package itself
RUN poetry install --no-interaction --no-ansi --no-dev

# Copy the rest of your application code
COPY . /app

# Create a non-root user and change ownership of the application directory
RUN addgroup --system app && adduser --system --ingroup app app && \
    chown -R app:app /app

# Switch to the non-root user
USER app

# Expose the port your application runs on
EXPOSE $PORT

# Set the default command to run your application
CMD ["poetry", "run", "python", "app/main.py"]