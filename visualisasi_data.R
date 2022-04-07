#ggplot2
#Empat komponen ggplot2 pada grafik, yaitu plot, data, aesthetic mapping, layer
#Geom: Bentuk geometri seperti garis, batang, titik
#Stat : suatu fungsi untuk melakukan transformasi statistik terhadap data input
#jiter : untuk membuat datanya tersebar dan tidak mengumpul di 1 titik
#identity : kebalikan dari jiter
library("ggplot2")
ggplot() + labs(title="ini plot aku", x="A", y="B")
#ScatterPlot <- layer(geom=" ", stat=" ", position=" ")
#1. geom = point(grafik titik), line(diagram garis), 
#hline(diagram garis horizontal), bar(diagram batang), histogram(histogram)
#2. stat = identity(tidak melakukan transformasi), bin(membagi data menjadi interval),
#sum(menjumlahkan nilai-nilai yg unik), 
#3. Position = identity(tidak melakukann perubahan), jitter(merubah posisi dengan jarak acak),
#stack(menyusun posisi dalam bentuk tumpukan)
data()
Orange 
plot.Orange  <- ggplot(data=Orange  , aes(x=age, y=circumference, color=Tree))
plot.Orange + layer(geom="point", stat="identity", position="identity")
#layer bisa juga di pakai dengan istilah geom_point()
plot.Orange + geom_point() + theme(plot.title = element_text(hjust=0.5)) +
  labs(title = "Jeruk", x="age", y="circumference", color="Tree")
#Histogram (Tipe visualisasi yang sangat cocok untuk menggambarkan data distribusi dari jumlah populasi data)
#geom_histogram
mpg 
hist.Orange <- ggplot(data=Orange , aes(x="age", fill= Tree))
hist.Orange + stat_count(width = 25)
hist.Orange
#Line Chart (Tipe visualisasi yg sangat baik untuk menggambarkan apa impact (pengaruh) dari perubahan suatu variabel dari satu titik ke titik yang lain)
inflasi <- read_csv("inflasi.csv")
View(inflasi)

inflasi$Bulan = factor(inflasi$Bulan, 
                                 levels = c("Jan-2017", "Feb-2017", "Mar-2017", "Apr-2017", "May-2017", "Jun-2017", "Jul-2017", "Aug-2017", "Sep-2017", "Oct-2017"))
plot.inflasi <- ggplot(data=inflasi, aes(x = Bulan,  y=Inflasi,  
                                         color=Negara, group=Negara))
plot.inflasi + geom_line() + geom_text(aes(label=Inflasi), hjust=-0.2, vjust=-.5)

#Bar Chart dan Pie Chart
datapenduduk <- read_csv("data-penduduk.csv")
View(datapenduduk)
plot.penduduk <- ggplot(data=Orange, aes(x = Tree, y=age, fill=circumference))
plot.penduduk + geom_bar(stat = "identity", position="dodge")
#aggregate <- dataframe yang kita gunakan pada plot, sering kali harus dilakukan summary terlebih sehingga dapat diproses lebih mudah oleh layer di ggplot
aggregate(x=list(ratarata=Orange$age), FUN=mean, by=list(Tree=Orange$Tree, circumference=Orange$circumference))
aggregate(x=list(jumlah=Orange$age), FUN=sum, by=list(Tree=Orange$Tree, circumference=Orange$circumference))
plot.penduduk <- ggplot(data=Orange, aes(x=age, y=circumference, fill=Tree, label = Tree))
plot.penduduk <- plot.penduduk + geom_bar(stat="identity", position="dodge") 
plot.penduduk <- plot.penduduk + labs(title="Jumlah Orange", x="Tree", y="Age")
plot.penduduk <- plot.penduduk + theme(axis.text.x = element_text(angle=45,vjust = 0.5), plot.title = element_text(hjust=0.5))
plot.penduduk <- plot.penduduk + geom_text(position = position_dodge(1.2))
plot.penduduk
#Pie Chart
plot.penduduk2 <- ggplot(data=Orange, aes(x="age", y=cicumference, fill = Tree))
plot.penduduk2 <- plot.penduduk2 + geom_bar(width = 1, stat = "identity")
plot.penduduk2 <- plot.penduduk2 + coord_polar("y", start=0)
plot.penduduk2
#Faceting (hanya memerlukan 1 variabel dan dibagi menjadi beberapa layer)
#Facet_wrap (Pie Chart) & facet_grid
plot.penduduk2 + facet_wrap(~Tree, ncol=2)
plot.penduduk + facet_wrap(~Tree, ncol=2)
hist.Orange <- ggplot(data=Orange, aes(x=age, fill=Tree))
hist.Orange <- hist.Orange + geom_histogram(aes(stat_count(width = 0.5)))
hist.Orange <- hist.Orange + labs(x="age", y="circumference", color="Tree")
hist.Orange + facet_wrap(~Tree, ncol=2)
hist.Orange
