# witdog_recodtester

witdog_recode

## 디렉토리구조
- View : 사용자에게 보여지는 영역 
- ViewModel : 상태를 관리하고 View의 비즈니스 로직을 담당 
- Repository 데이터 저장소라는 뜻으로 DataLayer인 DataSource에 접근 
- DataSource : 데이터를 가져오는 영역 
- Model : 데이터 설계

## Code Convention
- class : UpperCamelCase를 사용한다. (class, enum type, typedef, type parameter 일 경우) 
- variable : LowerCamelcase를 사용한다. (변수들, 클래스 멤버, 상위 레벨 정의 등등)
- getter/setter : 해당 부분에는 주석을 사용하지 않는다.
- 두가지 이상의 약어 또는 줄임말은 대문자로 표시한다.
- 문서 주석에서는 Markdown을 사용하지 않는다.
- 코드 블록을 사용 할 경우에는 `(백틱, 백쿼터)를 이용하여 코드블록을 작성한다. 
- package를 import 할때는 상대경로 대신에 절대경로를 이용하여 import 시킨다.
###
Ordering(정렬)
- dart: 로 시작하는 패키 제일 앞에 배치
- 섹션을 알파벳 순으로 정렬