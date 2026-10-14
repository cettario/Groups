from pathlib import Path
from lxml import etree

folder=Path(__file__).resolve().parent
source=etree.parse(str(folder/'orgs.xml'))
transform=etree.XSLT(etree.parse(str(folder/'grouping.xsl')))
result=transform(source)
(folder/'result.html').write_bytes(bytes(result))
print('Создан result.html')
