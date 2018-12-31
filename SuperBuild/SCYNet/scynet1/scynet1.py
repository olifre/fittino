
import math
import numpy as np
import tensorflow as tf
import os

class SCYNet:

    def __init__(self):

        self.x_min=None
        self.x_max=None
        self.x_mean=None
        self.x_stddev=None
        self.y_min=None
        self.y_max=None
        self.y_mean=None
        self.y_stddev=None
        self.x_mod_max=None
        self.y_mod_max=None

        self.sess=None

        self.x_in = None
        self.y = None 
        self.g = tf.Graph() 

        self.initialize_X_in_and_y()

    def initialize_X_in_and_y(self):
     
        N=[11,300,300,300,300,1]

        #create variables for weights and biases
        with self.g.as_default():
		self.x_in = tf.placeholder(tf.float32,shape=(1,N[0])) # net will be evaluated always for one batch
		a=[self.x_in] #outputs of all layers
		w=[]
		b=[]
		for i in range(0,len(N)-1):
		    w.append(tf.Variable(tf.random_normal([N[i], N[i+1]],mean=0.0,stddev=1.0/math.sqrt(N[i]*1.0)),name="w_"+str(i))) #weights[0]=W2
		    b.append(tf.Variable(tf.random_normal([N[i+1]]),name="b_"+str(i))) # biases[0]=b2
		    a.append(tf.tanh(tf.matmul(a[i], w[i]) + b[i])) 
		self.y =  a[len(N)-1]

    def apply_function_to_inputs(self, x):

        x_mod=np.ones(shape=(1,11))
        #z_score normalization
        for i in range(0,len(x)):
            for j in range(0,len(x[i])):
                x_mod[i][j]=(x[i][j]-self.x_mean[j])/self.x_stddev[j]
   
        for i in range(0,len(x)):
            for j in range(0,len(x[i])):
                x_mod[i][j]=x_mod[i][j]/self.x_mod_max[j]

        return x_mod


    def apply_inverse_function_to_outputs(self, y_mod):

        y = np.ndarray(shape=(1,1))#backtransformed output of net

        #z score normalization
        for i in range(0,len(y)):
            for j in range(0,len(y[i])):
                y[i][j]=y_mod[i][j]*self.y_mod_max[j]

        for i in range(0,len(y)):
            for j in range(0,len(y[i])):
                y[i][j]=y[i][j]*self.y_stddev[j]+self.y_mean[j]

        return y

    def startSession(self, energy):
       
        with self.g.as_default():
            self.setTransformationParameters( energy )
            self.sess = tf.Session(graph=self.g)
            net = 'direct_' + str( energy ) + 'TeV.ckpt'
        # net = getData( net )
            from pkg_resources import resource_filename
            net = os.path.abspath( resource_filename( 'scynet1.data', net ) )
#dummy = tf.Variable(0)
            saver = tf.train.Saver()
            saver.restore( self.sess, net )


    def setTransformationParameters(self, energy ):

        if energy == 8:

	    self.x_max=np.array([ 3998.23504782 , 3999.78823978 , 3996.61020348 , 4997.13243765 , 4985.61836211,
	2999.83531432 , 3999.50016348 , 3999.93507767 , 4998.67595591 , 4999.45034776,
	59.9941286 ])
            self.x_min=np.array([ -3.99907016e+03 ,  1.00035947e+02,  -3.99420860e+03,   3.00038370e+02,
	1.46599005e+02  , 1.00215626e+02 ,  1.07158432e+02 ,  1.14057116e+01,
	-4.99992884e+03 , -4.99782140e+03   ,1.02348006e+00])
	    self.y_max=np.array([ 100.])
	    self.y_min=np.array([ 31.06917746])
	    self.x_mean=np.array([   22.80628857,  1490.92536241 ,  894.14577569  ,2450.64955504,  2680.83189436,
	1620.77668953 , 2013.16041976 , 2001.50975689 ,  -66.57097025  , -55.78971629,
	26.20602196])
	    self.y_mean=np.array([ 55.95])
	    self.x_stddev=np.array([ 1765.37162051 , 1065.75765934 , 1919.26151219 , 1222.73306978  ,1088.62733005,
	704.31351228 ,  933.20169094 , 1043.19115111,  2358.96682234 , 2257.24183993,
	15.39152788])
	    self.y_stddev=np.array([ 23.00711265])
	    self.x_mod_max=np.array([ 2.27820386,  2.35406507 , 2.54699755 , 2.08261553 , 2.32791592 , 2.15892644,
	2.12852137 , 1.91568469 , 2.1472311  , 2.23956511 , 2.19524058])
	    self.y_mod_max=np.array([ 1.9146253])

        elif energy==13:

            self.x_max=np.array([ 3999.49492236 , 3999.78823978 , 3996.61020348 , 4991.45682079 , 4936.19202124,
  2999.83531432 , 3999.96091867 , 3999.93524406 , 4998.67595591,  4999.45034776,
    59.99075022])
	    self.x_min=np.array([ -3.99877535e+03,   1.00043706e+02 , -3.99515436e+03 ,  3.00038370e+02,
   1.46599005e+02 ,  1.00042998e+02 ,  1.00678566e+02 ,  7.27788257e-01,
  -4.99992884e+03,  -4.99821200e+03 ,  1.02348006e+00])
	    self.y_max=np.array([ 100.])
	    self.y_min=np.array([ 50.91384164])
	    self.x_mean=np.array([   16.89192785 , 1247.71638499 ,  676.96779325 , 1979.76186282 , 2242.18640787,
  1393.52862555 , 1759.81711878,  1694.8915135  ,   89.76303812  , -71.12378301,
    23.48578218])
	    self.y_mean=np.array([ 62.7])
	    self.x_stddev=np.array([ 1562.00381696 ,  917.38722271,  1502.88543666 , 1025.90463054 ,  966.65400264,
   650.55863351 ,  858.09362194  , 931.8065378 ,  2022.99833176 , 1955.17512945,
    13.54399907])
	    self.y_stddev=np.array([ 18.69027328])
	    self.x_mod_max=np.array([ 2.57084345 , 2.9999021  , 3.108768   , 2.93564808,  2.78693887 , 2.46911901,
  2.61060535 , 2.47373638 , 2.51591501,  2.59341174 , 2.69528725])
	    self.y_mod_max=np.array([ 1.99569046])


    def chi2(self, x):

        xp = np.ones(shape=(1,11))

        xp[0] = x

        x_mod = self.apply_function_to_inputs(xp)

        y_mod = self.sess.run(self.y,feed_dict={self.x_in:x_mod})

        y = self.apply_inverse_function_to_outputs(y_mod)

        return y[0][0]


    def closeSession(self):
        self.sess.close()
  


