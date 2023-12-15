import streamlit as st
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
import numpy as np

def price_prediction(df):
    st.subheader("Previsão de Preço de Aluguel")

    
    features = st.multiselect("Selecione as características para a previsão", df.columns, default=['sqfeet', 'beds', 'baths'])

    
    X = df[features]
    y = df['price']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    if st.button("Treinar Modelo"):
        
        model = RandomForestRegressor(n_estimators=100, random_state=42)
        model.fit(X_train, y_train)

        
        st.write("Score do Modelo:", model.score(X_test, y_test))

        
        st.write("Realizar uma previsão de preço:")
        input_values = []
        for feature in features:
            value = st.number_input(f"Insira o valor de {feature}", value=np.mean(df[feature]))
            input_values.append(value)

        if st.button("Prever"):
            prediction = model.predict([input_values])
            st.write(f"Previsão de Preço: ${prediction[0]:.2f}")