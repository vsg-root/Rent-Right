import streamlit as st
from modules.data_loader import load_data
from modules.descriptive_analysis import descriptive_analysis
from modules.visualizations import plot_correlation
from modules.clustering import perform_clustering
from modules.price_prediction import price_prediction

def main():
    st.sidebar.title("Navegação")
    choice = st.sidebar.selectbox("Escolha a Página", ["Home", "Análise Descritiva", "Visualizações", "Clusterização", "Previsão de Preço"])

    df = load_data("dataset\housing.parquet")  # Caminho atualizado

    if choice == "Home":
        st.subheader("Home")
        st.write("Bem-vindo ao aplicativo de análise de dados de imóveis!")
    elif choice == "Análise Descritiva":
        descriptive_analysis(df)
    elif choice == "Visualizações":
        plot_correlation(df)
    elif choice == "Clusterização":
        perform_clustering(df)
    elif choice == "Previsão de Preço":
        price_prediction(df)

if __name__ == "__main__":
    main()