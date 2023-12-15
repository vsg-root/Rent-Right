
import pandas as pd

# Carregar o dataset grande
df = pd.read_parquet("dataset\housing.parquet")

# Dividir e salvar por estado
for state, grupo in df.groupby('state'):  # Usando 'state' em vez de 'Estado'
    nome_arquivo = f'dataset_{state}.parquet'  # ou 'dataset_{estado}.csv' para CSV
    grupo.to_parquet(nome_arquivo, index=False)  # ou grupo.to_csv(nome_arquivo, index=False) para CSV


