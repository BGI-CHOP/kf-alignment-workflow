import sys

for i in range(1, 11):
	with open("sequence_grouping.interval_" + str(i) + ".txt","w") as tsv_file:
		tsv_file.write("hello")
		tsv_file.close()

