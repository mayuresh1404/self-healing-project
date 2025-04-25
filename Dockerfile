FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
# Install Ansible
RUN apt-get update && apt-get install -y ansible
COPY webhook.py ./
CMD ["python", "webhook.py"]