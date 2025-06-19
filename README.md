# 🚧 Data Warehouse - Análise de Acidentes Rodoviários Federais

Projeto desenvolvido como atividade avaliativa para a disciplina de **Tópicos Avançados de Banco de Dados (TABD)**, no curso de **Bacharelado em Sistemas de Informação** do **Instituto Federal de Alagoas (IFAL) - Campus Maceió**.

## 📌 Objetivos

Construir um Data Warehouse (DW) voltado à análise de dados dos acidentes ocorridos nas rodovias federais brasileiras, com foco na identificação de:

- Quantidade de feridos leves, feridos graves e óbitos.
- Rodovias e trechos (KM) com maior incidência de acidentes.
- Principais causas dos acidentes.

## 🛠️ Ferramentas Utilizadas

- 🧩 **Oracle SQL Developer Data Modeler** – para a modelagem relacional e dimensional do DW.
- 🗄️ **Oracle SQL Developer** – para criação e execução dos scripts no banco de dados.
- 📦 **Pentaho Data Integration** – para processos de **ETL (Extract, Transform, Load)**.
- 📊 **Microsoft Power BI** – para construção de **dashboards interativos**.
- 📁 **Dados da PRF (gov.br)** – utilizados como base primária em formato `.csv`.

## 🧠 Modelagem Dimensional

A modelagem adotada foi o Star Schema (Esquema Estrela), com uma tabela fato central contendo os dados quantitativos e seis tabelas dimensão com informações descritivas.

### 📌 Tabela Fato:
- Quantidade de acidentes.
- Feridos (leves e graves).
- Óbitos.

### 📎 Tabelas Dimensão:
- `dim_data`: data do acidente (ano, mês, dia, etc.).
- `dim_periodo`: período do dia (dia, noite, amanhecer, etc.).
- `dim_local`: estado, município, BR e quilômetro, longitude, latitude.
- `dim_causa`: causa do acidente.
- `dim_tipo`: tipo de acidente (colisão frontal, atropelamento, etc.).
- `dim_clima`: condição climática no momento do acidente (chuva, sol, etc.).

![image](https://github.com/user-attachments/assets/ed736439-6a30-4720-a4ab-c89e9b5417ea)

## 🔄 Processo de ETL

O processo de ETL foi automatizado com o Pentaho. Os dados foram extraídos de arquivos `.csv` da PRF e dos estados brasileiros, limpos, transformados e carregados no Data Warehouse com:

- Tratamento de dados.
- Criação automática de chaves substitutas (surrogate keys).
- Lookup nas dimensões para gerar a tabela fato.
- Job unificado para executar todas as transformações com um clique.

## 📊 Dashboards

Dois dashboards interativos foram criados no Power BI para análise dos dados de acidentes a partir das informações carregados no banco de dados:

### 🔹 Dashboard 1 – Visão Geral

- Identificação do local do acidente no mapa interativo através de dados de latitude/longitude (incluso no dashboard 2).
- Tabela com o total de mortos, feridos leves/graves.
- Ranking das cidades com mais acidentes.
- Gráficos de linha por tempo (ano, mês, etc.).
- Filtros por data, estado, BR, KM, tipo de acidente, causa do acidente, período do dia e clima (incluso no dashboard 2).


![image](https://github.com/user-attachments/assets/9518ab59-281d-4933-bd80-9df21c52a6f4)

### 🔹 Dashboard 2 – Rodovias e Causas

- Tabela com os quilômetros de cada BR com mais acidentes.
- Ranking de causas mais frequentes.


![image](https://github.com/user-attachments/assets/0fa8d4b8-9e0c-47b3-84f1-93907e5cb278)

> ⚠️ Os dados utilizados foram referentes ao ano de **2023**, com mais de **67 mil registros**.

## 📦 Como Executar o Projeto na Sua Máquina

### ✅ Requisitos

Certifique-se de ter os softwares instalados:

| Software | Versão mínima | Observações |
|----------|---------------|-------------|
| [Oracle Database](https://www.oracle.com/br/database/) | 21c | Usado para o Data Warehouse |
| [SQL Developer](https://www.oracle.com/tools/downloads/sqldev-downloads.html) | Qualquer | Para executar os scripts SQL |
| [Pentaho Data Integration (Kettle)](https://sourceforge.net/projects/pentaho/) | 9.x | Para rodar o ETL |
| [Power BI Desktop](https://powerbi.microsoft.com/pt-br/desktop/) | Qualquer | Para abrir os dashboards localmente |
| [Java (JDK)](https://www.oracle.com/java/technologies/downloads/) | 8 ou 11 |

### 📥 Passo 1: Clonar o Repositório

```bash
git clone https://github.com/deivisondelmiro/tabd
cd tabd
```

### 🧱 Passo 2: Confirme a seguinte estrutura das pastas:
```bash
├── carga\ - Transformações (.ktr) e job (.kjb) do Pentaho
├── csv\ - Dados de entrada em CSV
├── script\ - Script de criação do DW
```

### 🛠️ Passo 3: Criar o Banco de Dados no Oracle

```bash
Abra o SQL Developer.

Crie um novo usuário chamado sch_acd com a senha sch_acd.

Execute o script SQL localizado em:

C:\tabd_acidentes\script\script.sql
```

### 🔗 Passo 4: Conexão no Pentaho

```bash
Abra o Pentaho Data Integration e procure por conexões, confirmando as informações abaixo:

Banco: Oracle
Nome do servidor: localhost
Porta: 1521
Usuário: sch_acd
Senha: sch_acd
Nome do banco: /XEPDB1 (ou o nome que você usa)
```

### 🔄 Passo 5: Executar o ETL

```bash
No Pentaho:

Abra o Job Principal (job.kjb) em C:\tabd_acidentes\carga\job.kjb

Verifique os caminhos dos arquivos .csv em cada transformação (.ktr).

Clique no botão Start (Play).

O processo irá: carregar todas as dimensões, Carregar a tabela fato, opular todo o DW.
````

### 📊 Visualizar os Dashboards

```bash
Abra o Power BI Desktop.

Importe o arquivo .pbix localizado na pasta /BI do projeto.

Os dashboards estão prontos para uso.
```
