import streamlit as st
import pandas as pd
import folium
from folium.plugins import HeatMap
from streamlit_folium import folium_static

st.title("Mapa de Calor de Residências")

df = pd.read_csv('model\model_input_data.csv')

# Criar um mapa centrado em uma localização inicial
map_center = [df['lat'].mean(), df['long'].mean()]
mymap = folium.Map(location=map_center, zoom_start=4)

# Adicionar camada de calor com base nas coordenadas das residências
heat_data = df[['lat', 'long', 'price']].values.tolist()
HeatMap(heat_data, radius= 15).add_to(mymap)

# Exibir o mapa no Streamlit

folium_static(mymap)
