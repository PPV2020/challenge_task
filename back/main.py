from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title='CHALLENGE_2')

origins = [
    "http://localhost",
    "http://127.0.0.1",
    "http://prex_challenge:80"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_methods=["GET"],
    allow_headers=["Content-Type"]
)

@app.get("/api/status")
def get_status():
    return {'success': True, 'message': 'All Services Up and Running.'}

