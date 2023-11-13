import streamlit as st
from modules.data_loader import load_data
import seaborn as sns
import matplotlib.pyplot as plt

df = load_data("dataset\housing.parquet")  # Caminho atualizado

# Selecionando colunas específicas (ajuste conforme necessário)
selected_columns = ['price', 'sqfeet', 'beds', 'baths', 'cats_allowed', 'dogs_allowed']  # Exemplo
df_selected = df[selected_columns]

if st.checkbox("Mostrar Mapa de Calor de Correlação"):
    st.write("Mapa de Calor de Correlação")
    correlation_matrix = df_selected.corr()
    plt.figure(figsize=(15, 10))  # Tamanho ajustado
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm')
    st.pyplot(plt)
