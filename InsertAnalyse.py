html_file_a="C:\\Users\\LmScr\\Documents\\Work\\fabunion.github.com\\index.html"
html_file_b="D:\\Code\\FURobotDocument\\furobotGH_Doc\\Analyse.txt"


with open(html_file_b, 'r', encoding='utf-8') as file_b:
    content_b = file_b.read()

    # 读取文件A的内容
with open(html_file_a, 'r', encoding='utf-8') as file_a:
    content_a = file_a.read()

    # 查找并定位<head>标签的位置
head_index = content_a.find('</head>')

if head_index != -1:
        # 在<head>标签之前插入文件B的内容
    modified_content = content_a[:head_index] + content_b + content_a[head_index:]
        
        # 写入修改后的内容到文件A
    with open(html_file_a, 'w', encoding='utf-8') as file_a:
        file_a.write(modified_content)
    print(f"Successfully inserted content from {html_file_b} into {html_file_a}.")
else:
    print("Error: <head> tag not found in the HTML file.")