FROM python:3.11.7-slim-bookworm

SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c"]

WORKDIR /code

RUN apt-get install -y tzdata

ENV DEBIAN_FRONTEND=noninteractive \
    LANGUAGE=C.UTF-8 \
    ANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LC_CTYPE=C.UTF-8 \
    LC_MESSAGES=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ=America/Sao_Paulo

RUN apt-get update && \ 
    # Timezone
    apt-get install -y tzdata && \ 
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    apt install -y --no-install-recommends dumb-init  make build-essential \
    locales locales-all libpq-dev gcc libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev && \
    locale-gen pt_BR && update-locale LANG=pt_BR && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANGUAGE=pt_BR.UTF-8 \
    LANG=pt_BR.UTF-8 \
    LC_ALL=pt_BR.UTF-8 \
    LC_CTYPE=pt_BR.UTF-8 \
    LC_MESSAGES=pt_BR.UTF-8

RUN dpkg-reconfigure locales

COPY ./requirements.txt .

RUN pip install setuptools==44.1.1 --upgrade && \
    pip install --no-cache-dir -r requirements.txt

COPY ./entrypoint.sh .

ENTRYPOINT ["dumb-init", "--"]
CMD ["tail", "-f", "/dev/null"]