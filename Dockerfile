FROM python:3.14-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.14-slim AS runtime

#should i redefine workdir ? 
WORKDIR /app 

COPY --from=builder /usr/local/lib/python3.14/site-packages  /usr/local/lib/python3.14/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY . /app

EXPOSE 8001

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1


CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]