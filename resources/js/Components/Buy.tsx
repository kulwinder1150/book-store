import React, {useState} from "react";
import axios from "axios";
import {router} from "@inertiajs/react";
import Loader from "@/Components/Loader";
import {Simulate} from "react-dom/test-utils";
import load = Simulate.load;

function Buy({book_id}: any) {

    const [loader, setLoader] = useState(false)

    function handleBuy() {
        let data = new FormData();
        data.append('book_id', book_id);

        let config = {
            method: 'post',
            maxBodyLength: Infinity,
            url: '/api/orders',
            headers: {
                'Accept': 'application/json',
            },
            data: data
        };

        setLoader(true)
        axios.request(config)
            .then((response) => {
                if (response.status === 200) {
                    console.log(response.data?.message);
                    router.get(route('list-of-buy'))
                }
            })
            .catch((error) => {
                if (error?.response?.data?.error) {
                    alert(error?.response?.data?.error);
                }
                console.log(error);
            }).finally(() => {
                setLoader(false)
        })
    }

    return (
        <button
            onClick={handleBuy}
            className="px-3 py-1 bg-blue-500 text-white rounded-md hover:bg-blue-600 focus:outline-none focus:bg-blue-600">
            {loader && (
                <div className="flex justify-center items-center">
                    <div
                        className="animate-spin rounded-full h-4 w-4 border-t-2 border-b-2 border-white-900"></div>
                </div>
            ) || 'Buy'}
        </button>
    )
}

export default Buy
