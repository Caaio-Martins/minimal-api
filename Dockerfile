# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar tudo da raiz do projeto para o contêiner
COPY . ./

# Restaurar as dependências
RUN dotnet restore ./Api/minimal-api.csproj

# Publicar a aplicação
RUN dotnet publish ./Api/minimal-api.csproj -c Release -o /out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /out .

# Expor a porta da aplicação
EXPOSE 80

# Comando para iniciar a aplicação
ENTRYPOINT ["dotnet", "minimal-api.dll"]
