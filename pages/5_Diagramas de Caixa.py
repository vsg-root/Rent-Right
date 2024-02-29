import streamlit as st
from utils import load_data
import matplotlib.pyplot as plt

st.title("Diagramas de Caixa Box Plot")
analysis_df = load_data()


analysis_df = analysis_df[(analysis_df["price"] >= 340) & (analysis_df["price"] <= 3395)]


fig, ax = plt.subplots()
colunas = ["price", "sqfeet", "beds","baths"]
for coluna in colunas:
    ax.boxplot(analysis_df[coluna])
    ax.set_title("Boxplot for Identification of Outliers")
    ax.set_xlabel(coluna)
    ax.set_ylabel("Value")
    st.pyplot(fig)
