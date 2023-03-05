from flask import Flask, request

app = Flask(__name__)

users = {
    'elad': '1234',
    'david': '1234',
    'test': '1234'
}

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']
    if username in users and password == users[username]:
        return f'Hello, {username}!'
    else:
        return 'Invalid username or password'

@app.route('/')
def index():
    return '''
        <!DOCTYPE html>
        <html>
        <head>
            <title>Login</title>
        </head>
        <body>
            <h1>Login</h1>
            <form method="POST" action="/login">
                <label>Username:</label>
                <input type="text" name="username"><br>
                <label>Password:</label>
                <input type="password" name="password"><br>
                <input type="submit" value="Login">
            </form>
        </body>
        </html>
    '''

if __name__ == '__main__':
    app.run(debug=True)
