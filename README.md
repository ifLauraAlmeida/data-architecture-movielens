# MovieLens Data Architecture: End-to-End Analytics Pipeline

Este projeto apresenta a implementação de uma arquitetura de dados moderna (Modern Data Stack) para o processamento e análise de um volume superior a **6,2 milhões de registros** provenientes do dataset MovieLens[cite: 14]. A solução abrange desde a ingestão em nuvem até a entrega de dashboards estratégicos, utilizando uma estrutura de camadas para garantir a integridade e a performance das consultas.

## 🎯 Objetivo
Desenvolver uma infraestrutura escalável que transforme dados brutos de interações cinematográficas em insights sobre comportamento do usuário, performance de catálogo e janelas de engajamento.

![Diagrama feito com Excalidraw](architeture_diagram/diagram.png)

## 🛠️ Stack Técnica
* **Armazenamento:** Google Cloud Storage (GCS).
* **Data Warehouse:** Google BigQuery.
* **Transformação de Dados:** SQL (BigQuery Dialect).
* **Visualização:** Metabase (Containerizado via Docker).
* **Arquitetura:** Medallion (Bronze, Silver e Gold).

## 📂 Estrutura do Repositório

```
movielens-data-architecture/
├── infrastructure/
│   └── docker-compose.yml       # Configuração do Metabase via Docker
├── data_modeling/
│   ├── bronze/                  # Scripts de carga inicial e DDL de tabelas externas
│   ├── silver/                  # Queries de limpeza, casting e Regex
│   └── gold/                    # Camada semântica e Views de negócio
├── dashboard/
│   ├── queries_metabase.sql     # Mapeamento das consultas que alimentam o BI
│   ├── documentation.md         # Análise detalhada dos KPIs e Storytelling
│   └── screenshots/             # Registro visual do dashboard final
└── README.md                    # Documentação principal
```

## 🏗️ Arquitetura de Dados

O projeto segue o padrão **Medallion Architecture**, garantindo a linhagem e a qualidade dos dados em cada etapa:

1.  **Camada Bronze (Raw):** Ingestão dos arquivos CSV originais em tabelas externas no BigQuery, preservando o estado bruto dos dados armazenados no GCS.
2.  **Camada Silver (Cleaned):** Processamento e limpeza. Aplicação de `SAFE_CAST`, normalização de strings via Regex para extração de anos de lançamento e tratamento de valores nulos (`NULLIF`) para garantir a integridade estatística.
3.  **Camada Gold (Analytical):** Criação de camadas semânticas via Views. Esta camada foi projetada para otimizar o consumo por ferramentas de BI, consolidando KPIs como médias globais e performance por gênero.

## 📈 Insights e Resultados

A análise resultou em indicadores críticos para a compreensão do ecossistema de entretenimento:

* **Escala de Dados:** Monitoramento de 16.908 usuários únicos e 115.706 títulos catalogados[cite: 3, 12, 14].
* **Padrões Temporais:** Identificação de um pico de engajamento absoluto entre **20h e 21h**, com mais de 400 mil interações simultâneas[cite: 50].
* **Performance de Catálogo:** Distinção entre títulos de alta popularidade e alta qualidade (Ex: *Shawshank Redemption* com 10.8k avaliações)[cite: 17, 45].
* **Segmentação de Nicho:** O gênero *Noir* apresenta as maiores médias de avaliação, apesar do menor volume de interações[cite: 35].

## 🖼️ Visualização (Dashboard)

![](dashboard/screenshots/dashboard01.png)
![](dashboard/screenshots/dashboard02.png)

Abaixo estão as representações visuais da camada Gold consumida pelo Metabase:

### 1. Visão Geral de Performance e Popularidade
> **[INSERIR PRINT 01 AQUI: Dashboard principal ou gráfico de barras dos Top 10 filmes]**
*Análise de volume de interações vs. popularidade dos títulos.*

### 2. Matriz de Valor e Engajamento por Gênero
> **[INSERIR PRINT 02 AQUI: Scatter plot ou Bubble chart de Gêneros]**
*Correlação entre a média de avaliação e a quantidade de interações por categoria.*

### 3. Análise Térmica (Heatmap)
> **[INSERIR PRINT 03 AQUI: Heatmap de horários e dias da semana]**
*Mapeamento da "Janela de Ouro" para recomendações e marketing.*

## 🚀 Como Replicar este Projeto

### Pré-requisitos
* Conta no **Google Cloud Platform (GCP)** com projeto ativo.
* **Docker** e **Docker Compose** instalados localmente.
* SDK do Google Cloud (`gcloud`) configurado.

### Passo 1: Infraestrutura de Dados
1. Crie um Bucket no Google Cloud Storage e faça o upload dos arquivos `.csv` para uma pasta chamada `/bronze`.
2. No BigQuery, crie dois datasets: `movielens` (para a camada Bronze) e `movielens_analytics` (para Silver e Gold).
3. Execute os scripts SQL contidos em `data_modeling/bronze` para criar as tabelas externas apontando para o seu Bucket.

### Passo 2: Processamento (Silver & Gold)
1. Execute o script em `data_modeling/silver/transform_and_clean.sql` para gerar as tabelas persistentes de fatos e dimensões.
2. Execute o script em `data_modeling/gold/create_analytics_views.sql` para criar as views de consumo.

### Passo 3: Visualização (Metabase)
1. Navegue até a pasta `/infrastructure`.
2. Configure um arquivo `.env` com o caminho da sua chave JSON do GCP: `GCP_KEY_PATH=/seu/caminho/chave.json`.
3. Inicie o container:
   ```bash
   docker-compose up -d
4. Acesse localhost:3000, conecte o BigQuery utilizando sua chave JSON e aponte para as Views da camada Gold.
