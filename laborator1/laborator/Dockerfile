# Layer 1
FROM alpine:edge

#Layer 2 si 3
RUN apk add --update py3-pip
RUN python3 -m venv /venv

ENV PATH="/venv/bin:$PATH"

# Layer 4
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Layer 5 si 6
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/

EXPOSE 5000

CMD ["python3", "/usr/src/app/app.py"]