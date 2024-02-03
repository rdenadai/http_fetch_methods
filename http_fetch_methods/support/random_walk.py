import asyncio
from random import random
from typing import AsyncGenerator

from orjson import dumps

from http_fetch_methods.support.constants import IMG


async def randon_walk_wss(i) -> AsyncGenerator[dict, None]:
    yield {"n": i, "v": round(random(), 5), "img": IMG}


async def randon_walk_sse() -> AsyncGenerator[str, None]:
    try:
        i = 0
        while True:
            yield dumps({"n": i, "v": round(random(), 5), "img": IMG}).decode("utf-8")
            await asyncio.sleep(1)
            i += 1
    except asyncio.CancelledError as e:
        raise e
