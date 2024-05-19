import requests
from pathlib import Path
import argparse
from typing import Optional
import json
import datetime


def update_ships(work_dir: Path, application_id: str) -> Optional[Exception]:
    try:
        api_url = "https://api.worldofwarships.eu/wows/encyclopedia/ships/"
        new_json = {}
        page = 0
        while True:
            page += 1

            params = {
                "application_id": application_id,
                "language": "zh-cn",
                "page_no": page,
            }

            with requests.get(url=api_url, params=params) as response:
                response.raise_for_status()
                data = response.json()
                if data["status"] != "ok":
                    break
                new_json.update(data["data"])

        with open(work_dir / "ships.json", "r", encoding="utf-8") as file:
            old_json = json.load(file)["data"]

        for ship_id in new_json.keys():
            if ship_id in old_json.keys():
                new_json[ship_id]["name"] = old_json[ship_id]["name"]

        with open(work_dir / "ships.json", "w", encoding="utf-8") as file:
            json.dump(
                {
                    "update_at": datetime.datetime.now().timestamp(),
                    "data": new_json,
                },
                file,
                ensure_ascii=False,
                indent=4,
            )

    except Exception as error:
        return error


def update_norm_data(work_dir: Path) -> Optional[Exception]:
    try:
        with requests.get(
            "https://api.wows-numbers.com/personal/rating/expected/json/"
        ) as response:
            response.raise_for_status()
            data = response.json()
            with open(work_dir / "norm_data.json", "w") as file:
                json.dump(
                    data,
                    file,
                    ensure_ascii=False,
                    indent=4,
                )
    except Exception as error:
        return error


def main() -> None:
    parser = argparse.ArgumentParser(description="get working dir and application_id")

    parser.add_argument("--work_dir", type=str, default=".", help="work dir")
    parser.add_argument(
        "application_id",
        type=str,
        help="Application ID",
    )

    args = parser.parse_args()

    work_dir = Path(args.work_dir).resolve()
    application_id = args.application_id

    assert application_id is not None

    response_ships = update_ships(work_dir, application_id)
    response_norms = update_norm_data(work_dir)
    if response_ships:
        raise response_ships
    if response_norms:
        raise response_norms


if __name__ == "__main__":
    main()
