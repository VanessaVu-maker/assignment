from csv import writer, reader

#cau 5:
def group_tenure(tenure):
    if tenure >= 0 and tenure <=6:
        return '0-6 month'
    elif tenure > 9 and tenure <= 12:
        return '6-12 month'
    elif tenure > 12 and tenure <= 24:
        return '12-24 month'
    elif tenure > 24 and tenure <= 36:
        return '24-36 month'
    elif tenure > 36 and tenure <= 48:
        return '36-48 month'
    elif tenure > 48 and tenure <= 62:
        return '48-62 month'
    elif tenure > 62:
        return '>62 month'

def add_columm_in_csv(input_file, output_file, transform_row):
    with open(input_file, 'r') as read_obj, \
        open(output_file, 'w', newline='') as write_obj:
        csv_reader = reader(read_obj)
        csv_writer = writer(write_obj)
        for row in csv_reader:
            transform_row(row, csv_reader.line_num)
            csv_writer.writerow(row)

add_columm_in_csv(filename, filename_output, lambda row, line_num: row.insert(1, row[0] + row[1]))


