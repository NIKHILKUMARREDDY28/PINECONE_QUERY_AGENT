# Use the official Python 3.12 slim image for a small footprint
FROM python:3.12-slim

# Set environment variables:
# - Disable output buffering for easier logging.
# - Pin Poetry to a specific version.
# - Disable Poetry's virtual environment creation so dependencies install globally.
# - Set Poetry's installation directory to a system-wide location.
ENV PYTHONUNBUFFERED=1 \
    POETRY_VERSION=2.1.0 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_HOME=/opt/poetry \
    PATH="/opt/poetry/bin:$PATH"

# Install runtime dependencies required for installing Poetry
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    curl -sSL https://install.python-poetry.org | python3 - && \
    apt-get purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy only the dependency files first for better caching.
COPY pyproject.toml ./



# Copy the rest of your application code.
COPY . .

# Create a non-root user and change ownership of the application directory.
RUN addgroup --system app && adduser --system --ingroup app app && \
    chown -R app:app /app

# Switch to the non-root user.
USER app

# Expose the port your application runs on.
EXPOSE ${PORT:-8000}

# Set the default command to run your application.
CMD ["poetry", "run", "python", "app/main.py"]