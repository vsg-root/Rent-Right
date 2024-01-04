import streamlit as st
from utils import load_data

df = load_data()  # Caminho atualizado


col1, col2 = st.columns([8,1])
text ='<h1>Estatísticas Descritivas</h1>'
with col1:
    st.write(text, unsafe_allow_html=True)
with col2:
        st.image('assets\RentRightLogo.png')
st.markdown('''
##### Aqui você encontra as estatísticas do dataset utilizado, esta seção possui:

- **Total (count):** O número total de elementos na variável.
- **Desvio Padrão (Std):** A medida da dispersão dos valores em relação à média.
- **Média (mean):** O valor médio da variável.
- **Primeiro Quartil (25%):** O valor abaixo do qual 25% dos dados estão situados.
- **Segundo Quartil (50%):** A mediana, representando o ponto médio dos dados.
- **Terceiro Quartil (75%):** O valor abaixo do qual 75% dos dados estão situados.
- **Mínimo (Min):** O menor valor na variável.
- **Máximo (Max):** O maior valor na variável.

Essas estatísticas permitem uma visão da distribuição e da variação dos dados em cada variável do conjunto de dados.
            ''')
if st.checkbox("Mostrar Estatísticas Descritivas"):
    st.write(df.describe())

if st.checkbox("Mostrar legenda"):
    st.markdown('''
                
### Significado das variáveis
Aqui você pode ver o que cada variável analisada representa

| Nome da variável              | Descrição                                       |
|---------------------------|---------------------------------------------------|
| lat                       | Latitude da localização da propriedade.             |
| long                      | Longitude da localização da propriedade.            |
| price                     | Preço de aluguel da propriedade.                             |
| sqfeet                    | Área da propriedade em pés quadrados.         |
| beds                      | Número de quartos na propriedade.             |
| baths                     | Número de banheiros na propriedade.            |
| cats_allowed              | Permitido para gatos (1 para sim, 0 para não). |
| dogs_allowed              | Permitido para cães (1 para sim, 0 para não). |
| smoking_allowed           | Permitido fumar (1 para sim, 0 para não). |
| wheelchair_access         | Acessível para cadeira de rodas (1 para sim, 0 para não). |
| electric_vehicle_charge   | Carregamento para veículos elétricos (1 para sim, 0 para não). |
| comes_furnished           | Mobiliada (1 para sim, 0 para não). |
| type_                     | Tipo de imóvel. |
| laundry_options           | Opções de lavanderia. |
| parking_options           | Opções de estacionamento. |
| state_                    | Estado onde o imóvel está localizado. |

''') 
