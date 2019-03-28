
vintage <- c(2000:2017)

tank <- c(1:100)

wineries <- c("WSUWSC", "Beringer")

country <- c("Washington", "Oregon", "California", "New York", "Texas", "Argentina", "Chile", "France", "Italy", "Spain", "Germany", "South Africa", "Australia",
           "New Zealand")

regionMaster <- c("Ancient Lakes", "Columbia Gorge", "Columbia Valley", "Horse Heaven Hills", "Lake Chelan", "Naches Heights", "Puget Sound", 
                  "Rattlesnake Hills", "Red Mountain", "Snipes Mountain", "Wahluke Slope", "Walla Walla Valley", "Yakima Valley", "Applegate Valley", 
                  "Chehalem Mountains", "Columbia Gorge","Columbia Valley","Dundee Hills", "Elkton, Oregon",
                  "Eola-Amity Hills", "Hood River County", "McMinnville", "Polk County", "Red Hill Douglas County", "Ribbon Ridge", 
                  "Rogue Valley", "Southern Oregon", "The Rocks District of Milton–Freewater", "Umpqua Valley", "Walla Walla Valley",
                  "Washington County", "Willamette Valley", "Yamhill County", "Yamhill-Carlton District", "Alexander Valley", "Alta Mesa", 
                  "Anderson Valley", "Antelope Valley of the California High Desert", "Arroyo Grande Valley", 
                  "Arroyo Seco", "Atlas Peak", "Ballard Canyon","Ben Lomond Mountain", "Benmore Valley", "Bennett Valley", "Big Valley Lake County",
                  "Borden Ranch", "California Shenandoah Valley", "Calistoga", "Capay Valley", "Carmel Valley", "Central Coast", "Chalk Hill", 
                  "Chalone", "Chiles Valley", "Cienega Valley", "Clarksburg", "Clear Lake", "Clements Hills", "Cole Ranch", "Coombsville", "Cosumnes River", 
                  "Covelo", "Cucamonga Valley", "Diablo Grande", "Diamond Mountain District", "Dos Rios", "Dry Creek Valley", "Dunnigan Hills", "Edna Valley", 
                  "El Dorado", "Fair Play", "Fiddletown", "Fort Ross-Seaview", "Fountaingrove District", "Green Valley of Russian River Valley", 
                  "Guenoc Valley", "Hames Valley", "Happy Canyon of Santa Barbara", "High Valley", "Howell Mountain", "Jahant", 
                  "Kelsey Bench-Lake County","Knights Valley", "Leona Valley", "Lime Kiln Valley", "Livermore Valley", "Lodi", "Los Carneros", 
                  "Madera", "Malibu Coast", "Malibu-Newton Canyon", "Manton Valley", "McDowell Valley", "Mendocino", "Mendocino Ridge", "Merritt Island", 
                  "Mokelumne River", "Monterey", "Moon Mountain District Sonoma County","Mt. Harlan", "Mt. Veeder", "Napa Valley", "North Coast", "Northern Sonoma",
                  "North Yuba", "Oak Knoll District of Napa Valley", "Oakville", "Pacheco Pass", "Paicines", "Paso Robles", "Pine Mountain-Cloverdale", 
                  "Potter Valley", "Ramona Valley", "Red Hills Lake County", "Redwood Valley", "River Junction", "Rockpile", "Russian River Valley", 
                  "Rutherford", "Saddle Rock-Malibu", "Salado Creek", "San Antonio Valley", "San Benito", "San Bernabe", "San Francisco Bay", 
                  "San Lucas", "San Pasqual Valley", "Santa Clara Valley", "Santa Cruz Mountains", "Santa Lucia Highlands", 
                  "Santa Maria Valley", "Santa Ynez Valley", "San Ysidro District", "Seiad Valley", "Sierra Foothills", "Sierra Pelona Valley", 
                  "Sloughhouse", "Solano County Green Valley", "Sonoma Coast", "Sonoma Mountain", "Sonoma Valley","South Coast",
                  "Spring Mountain District", "St. Helena", "Sta. Rita Hills", "Stags Leap District", "Suisun Valley", "Temecula Valley", 
                  "Tracy Hills", "Trinity Lakes", "Wild Horse Valley", "Willow Creek", "York Mountain", "Yorkville Highlands", "Cayuga Lake", 
                  "Finger Lakes", "Hudson River Region", "Long Island", "Niagara Escarpment", "North Fork of Long Island", "Seneca Lake", 
                  "The Hamptons, Long Island", "Bell Mountain", "Escondido Valley", "Fredericksburg in the Texas Hill", "Texas Davis Mountains", 
                  "Texas High Plains", "Texas Hill Country", "Texoma", "Cafayate-Calchaqui Valley", "Catamarca", "Cuyo", "Famatina", "Fiambala", 
                  "Jujuy", "La Rioja", "Mendoza","Patagonia", "Salta", "San Juan", "Elqui Valley", "Limari Valley", "Choapa Valley", "Aconcagua Valley",
                  "Central Valley", "Leyda Valley", "Rapel Valley", "Acacama","Casablanca Valley", "San Antonio Valley", "Maipo Valley", "Cachapoal Valley", 
                  "Colchagua Valley", "Curico Valley", "Maule Valley","Itata Valley", "Bio Bio Valley", "Malleco Valley", "Alsace", "Armagnac",  "Bordeaux", 
                  "Burgundy", "Calvado", "Champagne", "Cognac",  "Corsica","Jura", "Languedoc-Roussillon", "loire", "Moselle", "Provence", "Rhone", 
                  "Savoie", "South West France","Vin De Pays", "Vin de Table", "Abruzzo", "Aosta Valley", "Basillicata", "Calabia", "Campania", "Emilia-Romagna", 
                  "Friuli-Venezia, Giulla", "Lazio", "Liguria", "Lombardy", "Marche", "Molise", "Piedmont", "Puglia", "San Marino","Sardinia", 
                  "Sicily", "Trentino-Alto Abige", "Tuscany", "Umbria","Veneto", "Vino da Tavola", "Andalucia", "Aragon", "Asturias", "Balcearic Islands", 
                  "Canary Islands","Cantanbria", "Castilla La Mancha", "Castilla y Leon", "Catalonia","Extemadura", "Galicia", "Madrid", "Murcia", "Ahr", "Baden", 
                  "Franken", "Hessische Bergstrasse", "Mosel", "Nahe", "Pfalz","Rheingau", "Rheinhessen", "Saale-Unstrut", "Sachsen", "Wurttemberg",
                  "Navarra", "Pais Vasco","Rioja", "Valencia", "Vinos de Pago", "Breede River Valley", "Cape Agulhas", "Coastal Region", "Elgin", 
                  "Klein Karoo","Olifants River Valley", "Orange River", "Overberg", "Walker Bay", "Western Cape", "New South Wales", "Northern Territory", 
                  "Queensland", "South Australia","South Eastern Australia", "Tasmania", "Victoria", "Western Australia", "Auckland", "Canterbury", 
                  "Central Otago", "Gisborne", "Hawkes Bay", "Marlborough", "Martinborough", "Nelson", "Northland", "Waiheke Island", "Waipara", "Wairarapa", 
                  "Waitaki Valley") 

cultivarMaster <- c(" ","Alicante", "Aglianico", "Aragon", "Barbera", "Bobal", "Blauer Lemberger", "Bonarda", "Cabernet Franc", "Cabernet Sauvignon", "Carignan", "Cariñena", 
                    "Carménère", "Cencibel", "Cinsaut", "Concord", "Cynthiana", "Dolcetto", "Domina", "Dornfelder", "Gamay", "Garnacha", "Grenache",  
                    "Juan García", "Lemberger", "Lenoir", "Listán Negro", "Manto Negro", "Mazuelo", "Mencía", "Malbec", "Mencía", "Merlot", "Monastrell", "Montepulciano",  
                    "Mourvedre", "Nebbiolo", "Nero d’Avola", "Petit Verdot", "Petit Sirah", "Pinot Noir", "Pinotage", "Portugieser","Primitivo & Negroamaro", "Ruby Cabernet", 
                    "Sangiovese", "Schwarzriesling", "Spätburgunder", "Syrah", "Tannat", "Tempranillo", "Tinto de Toro",  
                    "Trollinger",  "Trepat", "Valpolicella Blend", "Zinfandel")


calInstrument <- c("Olis 17", "Agilent 8453", "Thermo Fisher Genesys 10S")
calDilution <- c("15 fold", "10 fold", "5 fold")
CalTable <- data.frame(calInstrument, calDilution, row.names = NULL)
colnames(CalTable) <- c("Instrument ID", "Recommended Sample Dilution")
