def time_limit_test(GPU_check=True):
    'This function runs Google Colab in intensive mode, with GPU or CPU, when HardwareAccelerator is always GPU'
    # Source: https://keras.io/examples/cifar10_cnn/
    import keras
    from keras.datasets import cifar10
    from keras.models import Sequential
    from keras.layers import Dense, Dropout, Activation, Flatten
    from keras.layers import Conv2D, MaxPooling2D
    import os
    from datetime import datetime

    batch_size,num_classes,num_predictions = 32,10,20
    # The data, split between train and test sets:
    (x_train, y_train), (x_test, y_test) = cifar10.load_data()
    # Convert class vectors to binary class matrices.
    y_train = keras.utils.to_categorical(y_train, num_classes)
    y_test = keras.utils.to_categorical(y_test, num_classes)
    x_train , x_test = x_train.astype('float32')/255 , x_test.astype('float32')/255
    # Model Definition
    model = Sequential()
    model.add(Conv2D(32, (3, 3), padding='same', input_shape=x_train.shape[1:]))    ;    model.add(Activation('relu'))
    model.add(Conv2D(32, (3, 3)))                                                   ;    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))                                       ;    model.add(Dropout(0.25))
    model.add(Conv2D(64, (3, 3), padding='same'))                                   ;    model.add(Activation('relu'))
    model.add(Conv2D(64, (3, 3)))                                                   ;    model.add(Activation('relu'))
    model.add(MaxPooling2D(pool_size=(2, 2)))                                       ;    model.add(Dropout(0.25))
    model.add(Flatten())
    model.add(Dense(512))            ;    model.add(Activation('relu'))    ;    model.add(Dropout(0.5))
    model.add(Dense(num_classes))    ;    model.add(Activation('softmax'))
    # initiate RMSprop optimizer
    opt = keras.optimizers.rmsprop(lr=0.00001, decay=1e-6)
    model.compile(loss='categorical_crossentropy', optimizer=opt, metrics=['accuracy'])



    # Own Code begins here, which check limits for either of GPU & CPU
    i,init = 0,datetime.now()
    init, state = init.replace(second=0,microsecond=999999), 1
    print('Code Begins at Time',init,end='\n\n')

    while True:
        if GPU_check: 
            model.fit(x_train, y_train, batch_size=batch_size, epochs=5, validation_data=(x_test, y_test), shuffle=True, verbose=False)
            _ = datetime.now()
            print('\r{} Epochs in {}'.format(state,_-init),end='')
            state += 1
        else:
            _ = datetime.now()
            if not ((_-init).seconds%60):
                if state:
                    print('\rCPU only Execution from {}'.format(_-init),end='')
                    state = 0
            else:
                state = 1



if __name__ == '__main__':
    k = int(input('Enter 0 for CPU test 1 for GPU Test\n').strip())
    if k:
        # Testing GPU intensive limit allowed
        time_limit_test(GPU_check=True)
    else:
        # testing Maximum CPU intensive limit allowed
        time_limit_test(GPU_check=False)