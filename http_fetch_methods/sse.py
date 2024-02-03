from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware

# from fastapi.middleware.gzip import GZipMiddleware
from fastapi.staticfiles import StaticFiles
from sse_starlette.sse import EventSourceResponse

from http_fetch_methods.support.random_walk import randon_walk_sse
from http_fetch_methods.support.template import TEMPLATES

static = StaticFiles(directory="static", html=True)

app = FastAPI()
# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.mount("/static", static, name="static")
# app.add_middleware(GZipMiddleware, minimum_size=1000)


@app.get("/")
async def index(request: Request):
    return TEMPLATES.TemplateResponse(request=request, name="sse.html")


@app.get("/sse")
async def endless(req: Request) -> EventSourceResponse:
    return EventSourceResponse(randon_walk_sse())
