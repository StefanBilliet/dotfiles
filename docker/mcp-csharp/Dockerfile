FROM mcr.microsoft.com/dotnet/sdk:10.0

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl git nodejs npm \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g supergateway \
  && dotnet tool install --tool-path /usr/local/bin csharp-ls --version 0.22.0 \
  && dotnet tool install --tool-path /usr/local/bin csharplspmcp --version 1.0.0

ENV HOME=/root
ENV PATH="/usr/local/bin:${PATH}"

WORKDIR /workspace
