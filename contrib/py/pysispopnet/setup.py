from setuptools import setup, find_packages



setup(
  name="pysispopnet",
  version="0.0.1",
  license="ZLIB",
  author="jeff",
  author_email="jeff@i2p.rocks",
  description="sispopnet python bindings",
  url="https://github.com/sispop-project/sispop-network",
  install_requires=["pysodium", "requests", "python-dateutil"],
  packages=find_packages())