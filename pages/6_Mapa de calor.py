import streamlit as st
from utils import load_data, title
import seaborn as sns
import matplotlib.pyplot as plt

df = load_data()  # Caminho atualizado

title("Mapa de calor")
text= ''' Aqui será exibido um mapa de calor, este mapa irá mostrar as correlações entre características específicas, mostrando quais caracteristicas estão mais correlacionadas'''
st.write(text, unsafe_allow_html=True)
# Selecionando colunas específicas (ajuste conforme necessário)
selected_columns = st.multiselect("Selecione as características usadas no mapa de calor", df.columns, default=['price', 'sqfeet', 'beds', 'baths', 'cats_allowed', 'dogs_allowed'])
df_selected = df[selected_columns]

if st.button("Mostrar Mapa de Calor de Correlação"):
    st.write("Mapa de Calor de Correlação")
    correlation_matrix = df_selected.corr()
    plt.figure(figsize=(15, 10))  # Tamanho ajustado
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm')
    st.pyplot(plt)
