import axios from "axios";
import {useState} from "react";
import {router} from "@inertiajs/react";

function DeleteButton({id, books, setBooks}: any) {

    const [deleteLoading, setDeleteLoading] = useState(false)

    function handleDelete(e: any, id: any) {
        e.preventDefault();

        let data = new FormData();

        setDeleteLoading(true)

        let config = {
            method: 'delete',
            maxBodyLength: Infinity,
            url: `/api/books/${id}`,
            headers: {
                'Accept': 'application/json',
            },
            data: data
        };

        axios.request(config)
            .then((response) => {
                if (response.status === 202) {
                    router.get(route('books'))
                } else {
                    alert(JSON.stringify(response.data))
                }
            })
            .catch((error) => {
                alert(error?.message)
            })
            .finally(() => {
                setDeleteLoading(false)
            })
    }

    return (
        <button type={'button'}
                disabled={deleteLoading}
                onClick={(e) => handleDelete(e, id)}
                className="text-red-600 hover:text-red-900">
            {deleteLoading && (
                <span
                    className="inline-block mr-2 animate-spin rounded-full h-4 w-4 border-t-2 border-b-2 border-gray-900"></span>
            )}
            Delete
        </button>
    )
}

export default DeleteButton
