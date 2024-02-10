import streamlit as st
import xgboost
import numpy as np
import pickle
import pandas as pd
import tensorflow as tf
from utils import title
import joblib
from tensorflow.keras.models import load_model


df = pd.read_csv('model\model_input_data.csv')
old_UI = False
print(df)

def price_prediction(analysis_df):
    title("Previsão de Preço de Aluguel")
    x = analysis_df.drop('price', axis = 1)
    y = analysis_df['price']
        
    with open('model\model_xgb_mae_123.pkl', 'rb') as file:
        model = pickle.load(file)
    
    st.write("Insira as informações do imóvel desejado:")

    #UI velha (Usar para comparação de modelos e de resultados)
    if old_UI:
        input_values = []
        for feature in x:
            value = st.number_input(f"Insira o valor de {feature}", value=np.mean(df[feature]))
            input_values.append(value)

    #Nova UI começa aqui:
    user_inputs = [None for _ in range(14)] # Pode ser que bugue, mas relaxar com isso
    housing_types = ["Apartamento", "Residência assistida", "Condomínio", "Cabine", "Duplex", "Flat", "Casa", "Anexo", "Terreno", "Loft","Manufaturado", "Casa de cidade" ]

    col1, col2, col3 = st.columns([1,1,1])

    with col1:
        selected_housing =  st.selectbox("Qual o tipo de imóvel?", housing_types, index=0 )
        user_inputs[1] = housing_types.index(selected_housing)
        user_inputs[3] = st.number_input(f"Quantos quartos?", value=2, step=1, format="%d")
        user_inputs[11] = st.number_input(f"Qual a latitude do imóvel?", value=39.5483)

    with col2:
        user_inputs[2] = st.number_input(f"Qual o tamanho do imóvel? (SqFeet)", value= 750)
        user_inputs[4] = st.number_input(f"Quantos banheiros?", value=3, step=1, format="%d")
        user_inputs[12] = st.number_input(f"Qual a longitude do imóvel?", value=-119.746)

    with col3:
        user_inputs[0] = st.number_input(f"Qual o valor de região?", value= 286)
        user_inputs[13] = st.number_input(f"Qual o valor do estado?", value= 4)

    col4, col5, col6 = st.columns([1,1,1])

    with col4:
        if st.toggle('Permite gatos?'):
            user_inputs[5] = 1
        else:
            user_inputs[5] = 0

        if st.toggle('Acessível a cadeira de rodas?'):
            user_inputs[8] = 1
        else:
            user_inputs[8] = 0

    with col5:
        if st.toggle('Permite cachorros?'):
            user_inputs[6] = 1
        else:
            user_inputs[6] = 0

        if st.toggle('Possui carregador para carros elétricos?'):
            user_inputs[9] = 1
        else:
            user_inputs[9] = 0

    with col6:
        if st.toggle('Permite fumar?'):
            user_inputs[7] = 1
        else:
            user_inputs[7] = 0

        if st.toggle('Vem mobiliado?'):
            user_inputs[10] = 1
        else:
            user_inputs[10] = 0                
        
    if st.button("Gerar previsão!"):
        prediction = model.predict([user_inputs])

        print(f"predição 1: {prediction}")
        print(f"data_1: {user_inputs}")

        st.write(f'''<h5>Previsão de preço: ${prediction[0]:.2f} </h5>''', unsafe_allow_html= True)
        

    if old_UI:
        if st.button("Gerar previsão! (Old)"):
           prediction = model.predict([input_values])
           st.write(f'''<h5>Previsão de preço (old): ${prediction[0]:.2f} </h5>''', unsafe_allow_html= True)



price_prediction(df)