# Examples: Test-Driven Development

## Example 1: Red-Green-Refactor Cycle

**RED:** Write failing test
```python
def test_create_user_with_valid_data():
    user = create_user("test@example.com", "password123")
    assert user.email == "test@example.com"
```

**GREEN:** Make it pass
```python
def create_user(email, password):
    return User(email=email, password=hash_password(password))
```

**REFACTOR:** Improve code
```python
class UserFactory:
    @staticmethod
    def create(email, password):
        return User(email=email, password=hash_password(password))
```

## Example 2: AAA Pattern

```python
def test_user_login():
    # ARRANGE
    user = User(email="test@example.com", password="hashed123")
    
    # ACT
    result = authenticate(user, "password123")
    
    # ASSERT
    assert result.authenticated is True
    assert result.token is not None
```

## Example 3: Test Fixtures

```python
@pytest.fixture
def db_session():
    engine = create_engine("sqlite:///:memory:")
    Session = sessionmaker(bind=engine)
    session = Session()
    yield session
    session.close()

def test_create_user_persists_to_database(db_session):
    user = create_user(db_session, "test@example.com")
    saved = db_session.query(User).filter_by(email="test@example.com").first()
    assert saved.id == user.id
```
