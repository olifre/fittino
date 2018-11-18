import setuptools

setuptools.setup(
    name="scynet",
    packages=setuptools.find_packages(),
    package_data={
	"scynet.data": [ 
		"1.1565_03Aug.h5",
		"1.1565_03Aug.txt",
	],
    }
)		

