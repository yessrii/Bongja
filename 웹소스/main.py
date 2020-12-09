from flask import Flask, render_template, request
import pandas as pd
from werkzeug.utils import secure_filename
import matlab.engine
import os

app = Flask(__name__, static_folder='static')


@app.route('/')
def hello_world():
    print(os.path.dirname(__file__))
    return render_template('index.html')

@app.route('/instruction')
def instruction():
    return render_template('instruction.html')

@app.route('/try')
def try_self():
    return render_template('try_self.html')


@app.route('/result', methods = ['GET', 'POST'])
def result():
    os.chdir(os.path.dirname(__file__))
    f = request.files['file']
    file_path = '/static/input_file/' + secure_filename(f.filename)

    f.save('.'+file_path)

    print('file path : ' + file_path)

    input_file = 'static/input_file/'+f.filename

    eng=matlab.engine.start_matlab()
    result = eng.DogPredict(input_file)
    print('>>>>>>>>>',result, f.filename)

    return render_template('try_self.html', result = result, input_file = f.filename)
 

if __name__ == '__main__':
    app.run(host="0.0.0.0", port="8080", debug=True)
