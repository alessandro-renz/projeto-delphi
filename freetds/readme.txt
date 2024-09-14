Contents of this file
=====================

This zip-file contains the FreeTDS dblib implementation in the two flavours
32 bits 64 bits. Both are dynamicaly linked to libiconv 1.17. They are
provided here for Zeos users that don't want to compile their own libs.

If you need anything else go to www.freetds.org, get the source and compile
FreeTDS yourself. Instructions on how to do that can be found on the Zeoslib
Wiki:
https://sourceforge.net/p/zeoslib/wiki/Building%20FreeTDS%20with%20libiconv%20on%20Windows%2032%20Bits/

Although the files are named libsybdb-5.dll they really can communicate to Sybase
servers as well as Microsoft SQL Server.

On all Delphi unicode versions (Delphi 2009+) you almost always want to use
UTF-8 as the connection character set. On Ansi versions of Delphi (Delphi 7
to Delphi 2007) it makes sense to choose your local character set as the Zeos
connection character set.

License
=======
For the license of the libraries in this file see the respective LICENSE-*.txt
file in this directory.