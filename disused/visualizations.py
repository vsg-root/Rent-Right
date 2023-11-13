import streamlit as st
import seaborn as sns
import matplotlib.pyplot as plt

def plot_correlation(df):
    if st.checkbox("Mostrar Mapa de Calor de Correlação"):
        st.write("Mapa de Calor de Correlação")
        correlation_matrix = df.corr()
        plt.figure(figsize=(10, 5))
        sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm')
        st.pyplot(plt)
