k = [
    {
      "name": "Thông tin chung",
      "attributes": [
        {
          "code": "publisher_vn",
          "name": "Công ty phát hành",
          "value": "CÔNG TY TNHH HAPPY LIVE"
        },
        {
          "code": "publication_date",
          "name": "Ngày xuất bản",
          "value": "2022-08-01 15:52:09"
        },
        {
          "code": "dich_gia",
          "name": "Dịch Giả",
          "value": "Thái Phạm - Đỗ Phan Thu Hà"
        },
        {
          "code": "book_cover",
          "name": "Loại bìa",
          "value": "Bìa rời"
        },
        {
          "code": "number_of_page",
          "name": "Số trang",
          "value": "836"
        },
        {
          "code": "manufacturer",
          "name": "Nhà xuất bản",
          "value": "Nhà Xuất Bản Thế Giới"
        }
      ]
    }
  ]
print(k[0].get('attributes')[0].get('value'))