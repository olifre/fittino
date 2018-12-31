import setuptools

setuptools.setup(
    name="scynet1",
    packages=setuptools.find_packages(),
    package_data={
    "scynet1.data": [
        "direct_8TeV.ckpt",
        "direct_13TeV.ckpt",
    ],
    },
    scripts=['bin/test']

)

