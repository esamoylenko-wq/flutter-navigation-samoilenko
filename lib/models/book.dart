class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final int year;
  final String description;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.year,
    required this.description,
  });
}

class ReservedBook {
  final Book book;
  final DateTime returnDate;

  const ReservedBook({
    required this.book,
    required this.returnDate,
  });

  String get formattedReturnDate {
    final day = returnDate.day.toString().padLeft(2, '0');
    final month = returnDate.month.toString().padLeft(2, '0');
    final year = returnDate.year;
    return '$day.$month.$year';
  }
}

const List<String> kBookGenres = [
  'Усі',
  'Програмування',
  'Фантастика',
  'Класика',
  'Наукпоп',
];

const List<Book> kLibraryBooks = [
  Book(
    id: '1',
    title: 'Чистий код',
    author: 'Роберт Мартін',
    genre: 'Програмування',
    year: 2008,
    description: 'Посібник зі створення читабельного, підтримуваного та надійного програмного забезпечення.',
  ),
  Book(
    id: '2',
    title: 'Flutter у дії',
    author: 'Ерік Віндмілл',
    genre: 'Програмування',
    year: 2020,
    description: 'Практичний посібник із розробки кросплатформних мобільних застосунків на мові Dart та фреймворку Flutter.',
  ),
  Book(
    id: '3',
    title: 'Прагматичний програміст',
    author: 'Ендрю Гант, Девід Томас',
    genre: 'Програмування',
    year: 2019,
    description: 'Класичні поради для розробників від написання гнучкого коду до карʼєрного зростання в ІТ.',
  ),
  Book(
    id: '4',
    title: 'Патерни обʼєктно-орієнтованого проєктування',
    author: 'Еріх Гамма та ін.',
    genre: 'Програмування',
    year: 1994,
    description: 'Фундаментальна книга «Банди чотирьох» про 23 класичні шаблони проєктування ПЗ.',
  ),
  Book(
    id: '5',
    title: 'Дюна',
    author: 'Френк Герберт',
    genre: 'Фантастика',
    year: 1965,
    description: 'Епічна науково-фантастична сага про пустельну планету Арракіс, політику, екологію та виживання.',
  ),
  Book(
    id: '6',
    title: '1984',
    author: 'Джордж Орвелл',
    genre: 'Фантастика',
    year: 1949,
    description: 'Культовий роман-антиутопія про тоталітарний контроль, свободу думки та маніпуляцію правдою.',
  ),
  Book(
    id: '7',
    title: 'Фундація',
    author: 'Айзек Азімов',
    genre: 'Фантастика',
    year: 1951,
    description: 'Історія про науку психоісторію, яка дозволяє передбачити падіння Галактичної імперії.',
  ),
  Book(
    id: '8',
    title: 'Нейромант',
    author: 'Вільям Гібсон',
    genre: 'Фантастика',
    year: 1984,
    description: 'Засновницький роман жанру кіберпанк про хакерів, штучний інтелект та віртуальну реальність.',
  ),
  Book(
    id: '9',
    title: 'Тіні забутих предків',
    author: 'Михайло Коцюбинський',
    genre: 'Класика',
    year: 1911,
    description: 'Поетична повість про кохання Івана та Марічки на тлі гуцульських традицій та карпатської природи.',
  ),
  Book(
    id: '10',
    title: 'Місто',
    author: 'Валерʼян Підмогильний',
    genre: 'Класика',
    year: 1928,
    description: 'Перший урбаністичний роман в українській літературі про підкорення Києва молодим письменником.',
  ),
  Book(
    id: '11',
    title: 'Тигролови',
    author: 'Іван Багряний',
    genre: 'Класика',
    year: 1944,
    description: 'Пригодницький роман про боротьбу за свободу та людську гідність у сибірській тайзі.',
  ),
  Book(
    id: '12',
    title: 'Майстер і Маргарита',
    author: 'Михайло Булгаков',
    genre: 'Класика',
    year: 1967,
    description: 'Філософський роман про вічні цінності, творчість, кохання та містичні події.',
  ),
  Book(
    id: '13',
    title: 'Коротка історія часу',
    author: 'Стівен Гокінг',
    genre: 'Наукпоп',
    year: 1988,
    description: 'Доступне пояснення походження Всесвіту, чорних дір, природи простору та часу.',
  ),
  Book(
    id: '14',
    title: 'Sapiens: Людина розумна',
    author: 'Ювал Ной Харарі',
    genre: 'Наукпоп',
    year: 2011,
    description: 'Захоплива історія розвитку людства від камʼяної доби до технологічної революції XXI століття.',
  ),
  Book(
    id: '15',
    title: 'Егоїстичний ген',
    author: 'Річард Докінз',
    genre: 'Наукпоп',
    year: 1976,
    description: 'Погляд на теорію еволюції з точки зору генів як головних одиниць природного добору.',
  ),
  Book(
    id: '16',
    title: 'Мислення швидке й повільне',
    author: 'Деніел Канеман',
    genre: 'Наукпоп',
    year: 2011,
    description: 'Дослідження двох систем прийняття рішень людиною та когнітивних упереджень.',
  ),
];

Book? findBookById(String id) {
  for (final book in kLibraryBooks) {
    if (book.id == id) return book;
  }
  return null;
}