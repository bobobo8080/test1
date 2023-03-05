from flask import Flask


app = Flask(_name_)
@app.route('/')
def hello_name():
    return  'helloBen'

if _name_ == '_main_':
    app.run(host="0.0.0.0", port=5002)