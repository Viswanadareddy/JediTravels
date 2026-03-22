import firebase_admin
from firebase_admin import credentials, firestore

# Connect to Firebase
cred = credentials.Certificate('serviceAccountKey.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

# Hotel data
hotels = [
    {
        'name': 'Luxury Hotels',
        'location': 'Africa',
        'price': 440,
        'rating': '4.5',
        'image': 'assets/hotel_images/3.jpeg',
        'description': 'A luxury resort offering sophisticated ambience with modern design and decoration.',
        'category': 'recommended'
    },
    {
        'name': 'Evangeline Resorts',
        'location': 'Russia',
        'price': 400,
        'rating': '4.9',
        'image': 'assets/hotel_images/4.jpeg',
        'description': 'Premium resort with stunning views and world-class amenities.',
        'category': 'recommended'
    },
    {
        'name': 'Larry Homes',
        'location': 'Europe',
        'price': 420,
        'rating': '4.7',
        'image': 'assets/hotel_images/5.jpeg',
        'description': 'Elegant European property with exceptional service and comfort.',
        'category': 'recommended'
    },
    {
        'name': 'Jerry Restaurants',
        'location': 'Australia',
        'price': 430,
        'rating': '4.8',
        'image': 'assets/hotel_images/6.jpeg',
        'description': 'Modern Australian hospitality with premium dining facilities.',
        'category': 'recommended'
    },
    {
        'name': 'Empire Estates',
        'location': 'USA',
        'price': 420,
        'rating': '4.9',
        'image': 'assets/hotel_images/1.jpeg',
        'description': 'Iconic American hotel with premium facilities and stunning city views.',
        'category': 'popular'
    },
    {
        'name': 'Prime Hotels',
        'location': 'Germany',
        'price': 450,
        'rating': '4.6',
        'image': 'assets/hotel_images/2.jpeg',
        'description': 'Modern German hospitality at its finest with state of the art amenities.',
        'category': 'popular'
    },
    {
        'name': 'Baileys Residence',
        'location': 'Europe',
        'price': 410,
        'rating': '4.7',
        'image': 'assets/hotel_images/6.jpeg',
        'description': 'Charming European residence with personalised service and elegant rooms.',
        'category': 'popular'
    },
]

# Upload to Firestore
hotels_ref = db.collection('hotels')

for hotel in hotels:
    doc_ref = hotels_ref.add(hotel)
    print(f"Added: {hotel['name']}")

print(f"\nDone! {len(hotels)} hotels uploaded to Firestore.")
