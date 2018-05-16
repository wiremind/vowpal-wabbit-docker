from setuptools import setup, find_packages
import os

version = '1.0'

setup(name='s3uploader',
      version=version,
      description="",
      long_description="""
      """,
      classifiers=[
        ],
      keywords='',
      author='Cedric de Saint Martin',
      license='BSD',
      include_package_data=True,
      packages=['s3uploader',],
      zip_safe=False,
      install_requires=[
          'flask',
          'minio',
          'setuptools',
      ],
      entry_points={
          'console_scripts': [ 's3uploader=s3uploader:main']
      }
      )
