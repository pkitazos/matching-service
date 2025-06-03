FROM python:3.11.12-alpine3.22
LABEL org.opencontainers.image.source="https://github.com/pkitazos/matching-service"
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/
RUN adduser -D matching
WORKDIR /app

COPY pyproject.toml uv.lock .python-version .
RUN uv sync --frozen --no-cache

COPY . .

USER matching
CMD ["uv", "run", "--frozen", "--no-cache", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
