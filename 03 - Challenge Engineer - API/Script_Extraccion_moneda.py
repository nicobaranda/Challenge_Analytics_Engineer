# Importar librerias
import requests
import json
import pandas as pd

# Api URL - Formato para registros diarios con ultima cotizacion del dia - Delta de fechas
Monedas = requests.get("http://economia.awesomeapi.com.br/json/daily/BTC-BRL/31?start_date=20250301&end_date=20250331")
Monedas = Monedas.json()

# Convertir diccionario a cadena JSON
json_string = json.dumps(Monedas)

# Convertir cadena JSON en DataFrame de Pandas
dfjson = pd.read_json(json_string)

# Rellenar los valores NaN utilizando la funcion de relleno hacia adelante
dfnan = dfjson.fillna(method = 'ffill')

# Especificar columnas para nueva estructura
df_monedas = dfnan.loc[:, ['code','codein','bid','ask','timestamp']]

# Renombrar Columnas
df_monedas.rename(columns = {'code':'moneda_base', 'codein':'moneda_destino', 'bid':'valor_compra', 'ask':'valor_venda', 'create_date':'data_hora'}, inplace = True)

# Guardar Archivo CSV
df_monedas.to_csv('/Users/nicolasbaranda/Desktop/monedas_datos.csv', index = False)

print("Ejecuion Exitosa")