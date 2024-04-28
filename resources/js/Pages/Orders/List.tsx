import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout';
import {Head, Link, router} from '@inertiajs/react';
import {PageProps} from '@/types';
import axios from "axios";
import {useEffect, useState} from "react";
import InfiniteScroll from "react-infinite-scroller";
import Loader from "@/Components/Loader";

export default function List({auth, ...rest}: PageProps<any>) {

    const [loading, setLoading] = useState(false)
    const [orders, setOrders] = useState<any>([]);
    const [hasMore, setHasMore] = useState(true);
    const [currentPage, setCurrentPage] = useState(1);

    const fetchOrders = async (page: any) => {
        try {
            let config = {
                method: 'get',
                maxBodyLength: Infinity,
                url: `/api/orders?page=${page}&sortBy=id&sortOrder=desc&user_id=${auth.user.id}`,
                headers: {
                    'Accept': 'application/json',
                },
            };
            const data = await axios.request(config)
            setOrders((prevBooks: any) => [...prevBooks, ...data.data.data]);
            setCurrentPage(page);
            setHasMore(data.data.current_page < data.data.last_page);
        } catch (error) {
            alert(JSON.stringify(error));
            console.error('Error fetching books:', error);
        }
    };

    useEffect(() => {
        setLoading(true)
        fetchOrders(currentPage)
            .then(value => value)
            .finally(() => {
                setLoading(false)
            })
    }, []);

    const loadMore = async () => {
        await fetchOrders(currentPage + 1);
    };

    function handleCancel(id: any) {
        const result = confirm('Are you sure you want to cancel?');
        if (result) {
            let data = new FormData();
            data.append('_method', 'PUT');
            data.append('cancelled', 'true');

            let config = {
                method: 'post',
                maxBodyLength: Infinity,
                url: `/api/orders/${id}`,
                headers: {
                    'Accept': 'application/json',
                },
                data: data
            };

            axios.request(config)
                .then((response) => {
                    router.get(route('list-of-buy'));
                    // console.log(JSON.stringify(response.data));
                })
                .catch((error) => {
                    console.log(error);
                });
        }
    }

    function handleDelete(id: any) {
        const result = confirm('Are you sure you want to cancel?');
        if (!result) return;
        let data = new FormData();

        let config = {
            method: 'delete',
            maxBodyLength: Infinity,
            url: `/api/orders/${id}`,
            headers: {
                'Accept': 'application/json',
            },
            data: data
        };

        axios.request(config)
            .then((_response) => {
                router.get(route('list-of-buy'));
            })
            .catch((error) => {
                alert(error?.message)
            })
    }

    return (
        <AuthenticatedLayout
            user={auth.user}
            {...rest}
            header={<h2 className="font-semibold text-xl text-gray-800 leading-tight">List of Buy</h2>}
        >
            <Head title="Dashboard"/>

            <div className="py-12">
                <div className="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div className="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div className="p-6 text-gray-900">
                            {loading && (
                                <Loader/>
                            ) || (
                                <>
                                    {(orders.length > 0) && (
                                        <div className="overflow-x-auto">
                                            <InfiniteScroll
                                                pageStart={0}
                                                loadMore={loadMore}
                                                hasMore={hasMore}
                                                loader={<div key={'loader'}
                                                             className={'flex justify-center items-center'}>Loading...</div>}
                                            >
                                                <table className="table-auto min-w-full divide-y divide-gray-200">
                                                    <thead>
                                                    <tr>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Order</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Total</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Book</th>
                                                        <th className="px-6 py-3 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody className="bg-white divide-y divide-gray-200">
                                                    {orders.map((order: any, index: number) => (
                                                        <tr key={`book-${order.id}-${index}`}>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">#{order.id}</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">{order.date}</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">{order.total_amount}</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">{
                                                                order.cancelled ? (
                                                                    <div className={'bg-gray-100 p-2'}>Cancelled</div>
                                                                ) : (
                                                                    <div className={'bg-green-100 p-2'}>Completed</div>
                                                                )
                                                            }</td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">
                                                                <Link href={route('book-show', order.book_id)}
                                                                      className={'inline-block'}>
                                                                    <img src={order.book?.cover_image}
                                                                         alt={order.book?.title} width={50} height={50}/>
                                                                </Link>
                                                            </td>
                                                            <td className="px-6 py-4 whitespace-no-wrap text-sm leading-5 font-medium">
                                                                {!order.cancelled && (
                                                                    <button
                                                                        onClick={() => handleCancel(order.id)}
                                                                        className="bg-red-500 hover:bg-red-600 text-white font-bold py-1 px-2 mr-4 rounded">
                                                                        Cancel Request
                                                                    </button>
                                                                )}
                                                                <button type={'button'}
                                                                        onClick={() => handleDelete(order.id)}
                                                                        className="text-red-600 hover:text-red-900">
                                                                    Delete
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    ))}
                                                    </tbody>
                                                </table>
                                            </InfiniteScroll>
                                        </div>
                                    ) || (
                                        <div>Not Found!</div>
                                    )}
                                </>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
